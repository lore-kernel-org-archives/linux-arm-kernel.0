From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Sep 2014 10:56:21 +0100
Subject: [PATCH] arm: kprobes-test: Fix compile error "bad immediate
 value for offset"
In-Reply-To: <1412069601.1466.1.camel@linaro.org>
References: <1411743864.1529.36.camel@linaro1.home>
 <20140926151947.GV5182@n2100.arm.linux.org.uk>
 <1412069601.1466.1.camel@linaro.org>
Message-ID: <20140930095621.GK5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 10:33:21AM +0100, Jon Medhurst (Tixy) wrote:
> On Fri, 2014-09-26 at 16:19 +0100, Russell King - ARM Linux wrote:
> > I suspect it should be Olof - I'm just the middle man, spotting errors
> > in Olof's build results... though it did help that it was my for-next
> > branch which was being built.
> 
> I've added this patch to the patch tracker as 8179/1
> 
> I didn't add a Reported-by as I didn't receive a response from Olof and
> didn't want to add him without his say so; and I am assuming this matter
> isn't worth wasting peoples time chasing up...

I concur.  I'll apply it later today, thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
