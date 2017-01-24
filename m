From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 23 Jan 2017 16:51:07 -0800
Subject: [PATCH] ARM: Ignore compressed kernel build products
In-Reply-To: <20161208185449.7196-1-f.fainelli@gmail.com>
References: <20161208185449.7196-1-f.fainelli@gmail.com>
Message-ID: <d65b22f0-5eb1-2dd4-cd89-d6351ffe53f2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/2016 10:54 AM, Florian Fainelli wrote:
> When we select a kernel compression scheme, we will end-up with e.g:
> piggy.xzkern under arch/arm/boot/compressed/, let's ignore these files.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

I took the liberty to submit this patch as 8645/1 since it is a trivial
change. Thanks!
-- 
Florian
