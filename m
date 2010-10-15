From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Fri, 15 Oct 2010 23:00:40 +0300
Subject: [PATCH .36-rc8] arm: mm: allow, but warn, when issuing ioremap()
	on RAM
In-Reply-To: <20101015194255.GA12981@n2100.arm.linux.org.uk>
References: <1287152120-7201-1-git-send-email-felipe.contreras@gmail.com>
	<1287153021.27165.6.camel@e102109-lin.cambridge.arm.com>
	<20101015194255.GA12981@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinmAy13niqRKrray1Gk4hkr19tA2gWwYbfnFoh7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 15, 2010 at 10:42 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> As soon as the first ARM merge hits during the merge window, I'll be
> restoring the 'always fail' behaviour.

Ok, are you going to merge also your patch to use memblock for the
initialization? Many drivers could certainly use that to fix the
issue.

-- 
Felipe Contreras
