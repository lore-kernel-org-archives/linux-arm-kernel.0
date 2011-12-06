From: michael@walle.cc (Michael Walle)
Date: Tue, 6 Dec 2011 19:57:40 +0100
Subject: [PATCH 0/4] [orion] move *_mbus_dram_info out of platform_data
In-Reply-To: <1321599572-705-1-git-send-email-andrew@lunn.ch>
References: <1321599572-705-1-git-send-email-andrew@lunn.ch>
Message-ID: <201112061957.40740.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> As a step towords device tree support for orion based system, this
> patchset removes the *_mbus_dram_info from platform_data for various
> devices and replaces it with one instance of the strucutre in
> plat-orion and a getter function to retreive it. In order that
> none orion usage of these drivers still work, a dummy function is
> also provided which returns NULL, indicating it is not necassary
> to perform address map setup.
> 
> Boot tested on kirkwood, compile tested on other orion based systems.

For all four patches:

Tested-By: Michael Walle <michael@walle.cc>

-- 
Michael
