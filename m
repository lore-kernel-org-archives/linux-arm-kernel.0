From: nsekhar@ti.com (Nori, Sekhar)
Date: Thu, 18 Nov 2010 22:17:11 +0530
Subject: [PATCH v8 4/9] davinci: McASP configuration for Omapl138-Hawkboard
In-Reply-To: <AANLkTinu5tNSOhtBLJDMb+yj5ec1MQtEbGan4LZngCZK@mail.gmail.com>
References: <1289601535-6746-1-git-send-email-vm.rod25@gmail.com>
	<1289601535-6746-5-git-send-email-vm.rod25@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930234A2ABE7@dbde02.ent.ti.com>
	<4CE124AE.4080301@mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930234A2ACE1@dbde02.ent.ti.com>
	<4CE1560F.6080705@mvista.com>
	<AANLkTimDpYrx_OWg7ABXqRJ5JYzhpVbbyzVMhmFD6Wxi@mail.gmail.com>
	<4CE2AB73.3050109@mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930234ADA4BC@dbde02.ent.ti.com>
	<4CE2ECCD.8090603@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930247388682@dbde02.ent.ti.com>
	<AANLkTinu5tNSOhtBLJDMb+yj5ec1MQtEbGan4LZngCZK@mail.gmail.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930247388690@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Victor,

On Thu, Nov 18, 2010 at 22:08:34, Victor Rodriguez wrote:

[...]

> HI Sekhar
>
> Let me see if I understand, you prefer to remove the unused pin list,
> but that will produce a lot of changes on each board that used these
> pin list. I do not have those boards, in order to test if that works
> :(
>
> I want to help to fix it and give a complete and right support to the
> hawk board.
>
> Please give me a tip of how to do it

If you make the changes and post the patches,
we can ack for the EVM. Mike would be able
to test on the Mity-DSP platform.

Anyway, I expect the changes to be fairly innocuous.

Thanks,
Sekhar
