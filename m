From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Wed, 14 Jul 2010 12:13:07 +0300
Subject: ARM defconfig files
In-Reply-To: <201007121634.04427.davidb@codeaurora.org>
References: <alpine.LFD.2.00.1006030725420.8175@i5.linux-foundation.org>
	<201007121605.32462.davidb@codeaurora.org>
	<AANLkTimho3rcoCZZ2PlC3B3KIZZhsEiTnTk-__n1q_Dy@mail.gmail.com>
	<201007121634.04427.davidb@codeaurora.org>
Message-ID: <AANLkTimttp-YgYADPU5scbcSeb-7lb5d7Cf-_g_-0uJ7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 13, 2010 at 2:34 AM, David Brown <davidb@codeaurora.org> wrote:
> It seems a bit brute force, probably not something I can make part of
> our regular build process, but I can definitely run it before sending
> patches out.
>
> I wonder if there's a more efficient way of doing it that doesn't
> involve invoking make for each line of the file. ?It at least
> shouldn't be necessary to actually build the kernel each time.

Yes, I think there's a more efficient way to do it, but it would
require the SAT resolver, or something like that.

-- 
Felipe Contreras
