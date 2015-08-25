From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Aug 2015 10:54:07 +0100
Subject: [PATCH 0/2] arm64: ignore memory outside of the linear range
In-Reply-To: <CAKv+Gu-d77ab78WfT8r9YovrNXwFtpq4K9uKmSq5E1jOmRitYw@mail.gmail.com>
References: <1439890482-20798-1-git-send-email-ard.biesheuvel@linaro.org>
 <CY1PR0301MB0748FC71E6866C8AFACAAFF687780@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <CAKv+Gu-OQ4VyCqe=mEDOrrfAtAWTfRtAiqXMGSVjJxOH6xi4Ow@mail.gmail.com>
 <20150824092256.GA11262@arm.com>
 <CY1PR0301MB0748EAE8103DDF771A37785787620@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <20150824140828.GB20147@arm.com>
 <CY1PR0301MB07481C5861695902A75CD23D87620@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <CAKv+Gu-d77ab78WfT8r9YovrNXwFtpq4K9uKmSq5E1jOmRitYw@mail.gmail.com>
Message-ID: <20150825095407.GN7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 11:45:01AM +0200, Ard Biesheuvel wrote:
> On 25 August 2015 at 00:34, Stuart Yoder <stuart.yoder@freescale.com> wrote:
> > Ard, are you going to send to stable?
> >
> 
> We'll have to wait until the merge window closes, of course, but yes,
> we should propose it.

If it's important enough for stable, then it's important enough to go in
at _any_ time, merge window or not.  Fixes are _important_.

https://lwn.net/Articles/608917/

paragraph 3.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
