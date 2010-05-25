From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Tue, 25 May 2010 21:04:25 +0300
Subject: [PATCH v3 14/14] omap: mailbox: reorganize headers
In-Reply-To: <20100525054947.GA26007@nokia.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
	<1274548465-20208-15-git-send-email-felipe.contreras@gmail.com>
	<20100524171634.GA23202@nokia.com>
	<AANLkTimEtI3pDJKJOCyiBK8f0y1p0nyyIeptcS2eyy_v@mail.gmail.com>
	<20100525054947.GA26007@nokia.com>
Message-ID: <AANLkTik3wBTU4fiGdG7E_axF7gquYHzLI4Rx8EIQmpUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, May 25, 2010 at 8:49 AM, Felipe Balbi <felipe.balbi@nokia.com> wrote:
> On Mon, May 24, 2010 at 09:14:24PM +0200, ext Felipe Contreras wrote:
>> Now, I am pretty sure that platform_device.h will always depend on
>> device.h that's why I removed them, but I can add them again if
>> somebody wants to, but again, the situation is already bad.
>
> so there's platform_device.h on that file, a little comment on the changelog
> would suffice to avoid this kind of mis-understanding.

Sure, will do.

-- 
Felipe Contreras
