From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 25 May 2015 22:57:10 +0200
Subject: [PATCH v3 6/6] Documentation: dmaengine: document DMA_CTRL_ACK
In-Reply-To: <20150525165257.GI3140@localhost> (Vinod Koul's message of "Mon,
 25 May 2015 22:22:57 +0530")
References: <1431626006-1708-1-git-send-email-robert.jarzmik@free.fr>
 <1431626006-1708-6-git-send-email-robert.jarzmik@free.fr>
 <20150514183853.GN4004@lukather> <87twvekij8.fsf@belgarion.home>
 <20150525165257.GI3140@localhost>
Message-ID: <87r3q41il5.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@intel.com> writes:

>> > Also, we should still mention that it's !slave API only.
>> Certainly not, it's fully slave API, that's the purpose of this patch.
> Its is not dependent on slave, it cna be used by slave as well as other
> users
You're right Vinod. I will rephrase that : this applies for both slave and
!slave.

Cheers.

-- 
Robert
