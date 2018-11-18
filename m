From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 18 Nov 2018 16:55:49 +0100 (CET)
Subject: [PATCH 00/16] staging: vchiq: dead code removal & misc fixes
In-Reply-To: <20181114125942.25163-1-nsaenzjulienne@suse.de>
References: <20181114125942.25163-1-nsaenzjulienne@suse.de>
Message-ID: <1128999886.40745.1542556549581@email.ionos.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 14. November 2018 um 13:59 geschrieben:
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

without a changelog i won't start a review.

Regards
Stefan
