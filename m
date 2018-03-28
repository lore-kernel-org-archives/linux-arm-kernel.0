From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 28 Mar 2018 11:48:33 -0700
Subject: [PATCH] memory: brcmstb: dpfe: Remove need for dpfe_dev
In-Reply-To: <20180327234038.32241-1-f.fainelli@gmail.com>
References: <20180327234038.32241-1-f.fainelli@gmail.com>
Message-ID: <20180328184833.23369-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Mar 2018 16:40:38 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> We can hook sysfs objects to the parent platform device that we are
> created from, no need to have a synthetic dpfe_dev just for that. This
> incidentally removes the need for having an index, since we are
> guaranteed to have an unique path in the sysfs hiearchy.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to drivers/next, thanks!
--
Florian
