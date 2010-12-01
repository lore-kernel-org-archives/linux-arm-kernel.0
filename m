From: vm.rod25@gmail.com (Victor Rodriguez)
Date: Wed, 1 Dec 2010 10:13:01 -0600
Subject: [PATCH v8 4/9] davinci: McASP configuration for Omapl138-Hawkboard
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930247AFDA6E@dbde02.ent.ti.com>
References: <1289601535-6746-1-git-send-email-vm.rod25@gmail.com>
	<1289601535-6746-5-git-send-email-vm.rod25@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930247AFD99E@dbde02.ent.ti.com>
	<AANLkTi=Zjya8n0h3npfdQAR6Nx+YU1-T-EFe2Cqcmnwn@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930247AFDA6E@dbde02.ent.ti.com>
Message-ID: <AANLkTiknoVtTaiEt=Vk7o3JBwi3tbhq46wgGCR57c3oj@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By the way I will eliminate 3 of my patches

[PATCH v8 3/9] davinci: ASoC support for Omapl138-Hawkboard
[PATCH v8 4/9] davinci: McASP configuration for Omapl138-Hawkboard
[PATCH v8 5/9] davinci: Audio support for Omapl138-Hawkboard

Because if I eliminate the  McASP configuration I can not enable the
audio support for the board, the kernel compiles and the sound card is
recognized but when I try to play any file on the board it will not
produce any error but no sound will be produced either

So in order to do not give a wrong support I will eliminate the audio
support for hawk board

Regards

Victor Rodriguez




On Wed, Dec 1, 2010 at 10:04 AM, Nori, Sekhar <nsekhar@ti.com> wrote:
> On Wed, Dec 01, 2010 at 20:50:04, Victor Rodriguez wrote:
>>
>> Yes Sekhar I will do it ?right now, sorry for the delay with the other
>> patch that fix this
>
> The issue was not yours to fix. The generic pin lists need to be cleaned
> up regardless. So, don't be sorry :)
>
> Thanks,
> Sekhar
>
>
