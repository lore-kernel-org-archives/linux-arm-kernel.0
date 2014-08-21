From: holler@ahsoftware.de (Alexander Holler)
Date: Thu, 21 Aug 2014 21:19:00 +0200
Subject: [RFC PATCH 0/9] dt: dependencies (for deterministic driver
 initialization order based on the DT)
In-Reply-To: <20140821140211.GD19293@ulmo.nvidia.com>
References: <1399913280-6915-1-git-send-email-holler@ahsoftware.de>
 <20140514141914.446F7C4153D@trevor.secretlab.ca>
 <20140821140211.GD19293@ulmo.nvidia.com>
Message-ID: <53F64624.5000403@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 21.08.2014 16:02, schrieb Thierry Reding:

> Anyway, those are all fairly standard reasons for where deferred probe
> triggers, and since I do like deferred probe for it's simplicity and
> reliability I'd rather not try to work around it if boot time is all
> that people are concerned about.

It's neither simple nor reliable. It's non deterministic brutforcing 
while making it almost impossible to identify real errors.

In my humble opinion the worst way to solve something. I'm pretty sure 
if I would have suggest such a solution, the maintainer crowd would have 
eaten me without cooking.

Regards,

Alexander Holler
