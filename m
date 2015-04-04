From: ipaton0@gmail.com (Iain Paton)
Date: Sat, 04 Apr 2015 11:30:29 +0100
Subject: [PATCH] sunxi: a10-lime: add regulator nodes
In-Reply-To: <20150330222311.GY23664@lukather>
References: <551537ED.7060402@gmail.com> <551538AB.50207@redhat.com>
 <55169622.5070007@gmail.com> <20150330222311.GY23664@lukather>
Message-ID: <551FBD45.3060503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/03/15 23:23, Maxime Ripard wrote:

> CSI is not usable (no driver for it), neither it is actually used by
> default on the lime, so disabling the regulator is the right thing to
> do.

My userspace code works just fine, until the regulator gets turned off.

Anyway, I don't have the patience Hans showed with the simplefb stuff.
So consider yourselves successful in wearing me down. I'm done debating 
any of this. One less contributor to linux-sunxi for you to worry about, 
I won't bother you anymore.

> Too bad.

For who?  

Rgds,
Iain
