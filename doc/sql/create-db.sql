create table ActivityType (id integer not null auto_increment, name varchar(255) not null unique, description text, targetSpendingPercentage integer not null check (targetSpendingPercentage>=0 and targetSpendingPercentage<=100), primary key (id)) type=InnoDB;
create table Backlog (backlogtype varchar(31) not null, id integer not null auto_increment, name varchar(255), description text, startDate datetime, endDate datetime, deliverable_id integer, product_id integer, activityType_id integer, owner_id integer, assignee_id integer, primary key (id)) type=InnoDB;
create table BacklogItem (id integer not null auto_increment, priority integer, name varchar(255), description text, status integer, remainingEffortEstimate integer, iterationGoal_id integer, backlog_id integer not null, assignee_id integer, primary key (id)) type=InnoDB;
create table BacklogItem_User (watchedBacklogItems_id integer not null, watchers_id integer not null) ENGINE=InnoDB;
create table Task (id integer not null auto_increment, created datetime, effortEstimate integer, status integer, name varchar(255), priority integer, description text, creator_id integer, backlogItem_id integer not null, assignee_id integer, primary key (id)) type=InnoDB;
create table Task_User (watchedTasks_id integer not null, watchers_id integer not null) ENGINE=InnoDB;
create table TaskEvent (id integer not null auto_increment, created datetime, actor_id integer, task_id integer not null, eventType varchar(31), comment varchar(255), effort integer, newEstimate integer, workType_id integer, oldAssignee_id integer, newAssignee_id integer, primary key (id)) type=InnoDB;
create table User (id integer not null auto_increment, loginName varchar(255) unique, fullName varchar(255), description text, password varchar(255), primary key (id)) type=InnoDB;
create table WorkType (id integer not null auto_increment, name varchar(255) not null, description text, activityType_id integer, primary key (id)) type=InnoDB;
create table IterationGoal (id integer not null auto_increment, name varchar(255), priority integer, description text, status integer, iteration_id integer not null, primary key (id)) ENGINE=InnoDB;
create table Practice (id integer not null auto_increment, name varchar(255), description text, template_id integer, primary key (id)) ENGINE=InnoDB;
create table PracticeAllocation (id integer not null auto_increment, status integer, task_id integer, practice_id integer, primary key (id)) ENGINE=InnoDB;
create table PracticeTemplate (id integer not null auto_increment, primary key (id)) ENGINE=InnoDB;
alter table Backlog add index FK4E86B8DD5600C562 (deliverable_id), add constraint FK4E86B8DD5600C562 foreign key (deliverable_id) references Backlog (id) ON DELETE CASCADE;
alter table Backlog add index FK4E86B8DD2D47BAEA (owner_id), add constraint FK4E86B8DD2D47BAEA foreign key (owner_id) references User (id) ON DELETE SET NULL;
alter table Backlog add index FK4E86B8DDCC65BE32 (activityType_id), add constraint FK4E86B8DDCC65BE32 foreign key (activityType_id) references ActivityType (id) ON DELETE SET NULL;
alter table Backlog add index FK4E86B8DDA7FE2362 (product_id), add constraint FK4E86B8DDA7FE2362 foreign key (product_id) references Backlog (id) ON DELETE CASCADE;
alter table Backlog add index FK4E86B8DD31FA7A4E (assignee_id), add constraint FK4E86B8DD31FA7A4E foreign key (assignee_id) references User (id);
alter table BacklogItem add index FKC8B7F1907A2D5E2 (iterationGoal_id), add constraint FKC8B7F1907A2D5E2 foreign key (iterationGoal_id) references IterationGoal (id);
alter table BacklogItem add index FKC8B7F190F63400A2 (backlog_id), add constraint FKC8B7F190F63400A2 foreign key (backlog_id) references Backlog (id) ON DELETE CASCADE;
alter table BacklogItem add index FKC8B7F19031FA7A4E (assignee_id), add constraint FKC8B7F19031FA7A4E foreign key (assignee_id) references User (id);
alter table BacklogItem_User add index FK4CB3A13AEBB4AC41 (watchedBacklogItems_id), add constraint FK4CB3A13AEBB4AC41 foreign key (watchedBacklogItems_id) references BacklogItem (id) ON DELETE CASCADE;
alter table BacklogItem_User add index FK4CB3A13A1BBD70E6 (watchers_id), add constraint FK4CB3A13A1BBD70E6 foreign key (watchers_id) references User (id) ON DELETE CASCADE;
alter table Task add index FK27A9A51C5D0ED1 (creator_id), add constraint FK27A9A51C5D0ED1 foreign key (creator_id) references User (id) ON DELETE SET NULL;
alter table Task add index FK27A9A5E94683E2 (backlogItem_id), add constraint FK27A9A5E94683E2 foreign key (backlogItem_id) references BacklogItem (id) ON DELETE CASCADE;
alter table Task add index FK27A9A531FA7A4E (assignee_id), add constraint FK27A9A531FA7A4E foreign key (assignee_id) references User (id) ON DELETE SET NULL;
alter table Task_User add index FK822CAE45E1785597 (watchedTasks_id), add constraint FK822CAE45E1785597 foreign key (watchedTasks_id) references Task (id) ON DELETE CASCADE;
alter table Task_User add index FK822CAE451BBD70E6 (watchers_id), add constraint FK822CAE451BBD70E6 foreign key (watchers_id) references User (id) ON DELETE CASCADE;
alter table TaskEvent add index FK80CD17F56E84F892 (task_id), add constraint FK80CD17F56E84F892 foreign key (task_id) references Task (id) ON DELETE CASCADE;
alter table TaskEvent add index FK80CD17F567C4A468 (actor_id), add constraint FK80CD17F567C4A468 foreign key (actor_id) references User (id) ON DELETE SET NULL;
alter table TaskEvent add index FK80CD17F54F7702F2 (workType_id), add constraint FK80CD17F54F7702F2 foreign key (workType_id) references WorkType (id) ON DELETE SET NULL;
alter table TaskEvent add index FK80CD17F5C1D03DC7 (oldAssignee_id), add constraint FK80CD17F5C1D03DC7 foreign key (oldAssignee_id) references User (id) ON DELETE SET NULL;
alter table TaskEvent add index FK80CD17F5EC8C8CAE (newAssignee_id), add constraint FK80CD17F5EC8C8CAE foreign key (newAssignee_id) references User (id) ON DELETE SET NULL;
alter table WorkType add index FK5EE3E0BCC65BE32 (activityType_id), add constraint FK5EE3E0BCC65BE32 foreign key (activityType_id) references ActivityType (id) ON DELETE CASCADE;
alter table IterationGoal add index FKBCC95B704157D2A2 (iteration_id), add constraint FKBCC95B704157D2A2 foreign key (iteration_id) references Backlog (id);