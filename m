From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 28 Oct 2014 09:50:13 -0200
Subject: [PATCH v6 4/7] ARM: l2c: Add support for overriding prefetch
 settings
In-Reply-To: <20141028113531.GZ12379@n2100.arm.linux.org.uk>
References: <1414407950-3029-1-git-send-email-m.szyprowski@samsung.com>
 <1414407950-3029-5-git-send-email-m.szyprowski@samsung.com>
 <20141027111404.GW12379@n2100.arm.linux.org.uk>
 <544E2A46.7070106@samsung.com>
 <20141028113531.GZ12379@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5Ddp1=4K6qNmLxi-=TKmEFDm5B+7XRLkemrYMCPzZAjJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 9:35 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Ok.
>
> I'd ask for one change.  Please make all these messages start with
> "L2C-310 OF" not "PL310 OF:".  The device is described in ARM
> documentation as a L2C-310 not PL310.  (Also note the : is dropped
> too - most of the other messages don't have the : either.)
>
> The:
>
> "PL310 OF: cache setting yield illegal associativity
> PL310 OF: -1073346556 calculated, only 8 and 16 legal"

I have sent a patch to address this error message that happens when
"cache-size" and "cache-sets" properties are not passed in DT:
http://www.spinics.net/lists/arm-kernel/msg372094.html
