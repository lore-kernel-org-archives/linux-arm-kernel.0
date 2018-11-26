From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 26 Nov 2018 20:36:33 +0100 (CET)
Subject: [PATCH 00/16] staging: vchiq: dead code removal & misc fixes
In-Reply-To: <20181120145351.30390-1-nsaenzjulienne@suse.de>
References: <20181120145351.30390-1-nsaenzjulienne@suse.de>
Message-ID: <2009845931.201432.1543260993249@email.ionos.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 20. November 2018 um 15:53 geschrieben:
> 
> 
> Hi All,
> 
> This series was written in parallel with reading and understanding the
> vchiq code. So excuse me for the lack of logic in the sequence of
> patches.
> 
> The main focus was to delete as much code as possible, I've counted
> around 550 lines, which is not bad. Apart from that there are some
> patches enforcing proper kernel APIs usage.
> 
> The only patch that really changes code is the
> vchiq_ioc_copy_element_data() rewrite.
> 
> The last commit updates the TODO list with some of my observations, I
> realise some of the might be a little opinionated. If anything it's
> going to force a discussion on the topic, which is nice.
> 
> It was developed on top of the latest linux-next, and was tested on a
> RPIv3B+ with audio, video and running vchiq_test.
> 
> Regards,
> Nicolas
> 
> RFC -> PATCH, as per Stefan's comments:
>   - Remove semaphore initialization from remove_event_create()
>     (commit 9)
>   - Join all three semaphore to completion patches (commit 11)
>   - Update probe/init commit message (commit 14)
>   - Update TODO commit message and clean up (commit 16)
>   - Fix spelling on some of the patches
> 

The whole series is

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Unfortunately patch 05 might not apply.
