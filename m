From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 22 Aug 2014 14:19:19 +0100
Subject: [RFC PATCH 0/9] dt: dependencies (for deterministic driver
 initialization order based on the DT)
In-Reply-To: <53F64624.5000403@ahsoftware.de>
References: <1399913280-6915-1-git-send-email-holler@ahsoftware.de>
 <20140514141914.446F7C4153D@trevor.secretlab.ca>
 <20140821140211.GD19293@ulmo.nvidia.com>
 <53F64624.5000403@ahsoftware.de>
Message-ID: <20140822131919.GX21734@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 08:19:00PM +0100, Alexander Holler wrote:
> Am 21.08.2014 16:02, schrieb Thierry Reding:
> 
> > Anyway, those are all fairly standard reasons for where deferred probe
> > triggers, and since I do like deferred probe for it's simplicity and
> > reliability I'd rather not try to work around it if boot time is all
> > that people are concerned about.
> 
> It's neither simple nor reliable. It's non deterministic brutforcing 
> while making it almost impossible to identify real errors.

It's horrible, yes.

> In my humble opinion the worst way to solve something. I'm pretty sure 
> if I would have suggest such a solution, the maintainer crowd would have 
> eaten me without cooking.

We didn't have a better workable solution at the time. Having a hack
that got boards booting was considered better than not having them boot.
I don't remember people being particularly enthralled by the idea.

Thanks,
Mark.
