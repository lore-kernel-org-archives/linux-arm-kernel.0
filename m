From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 19 Jan 2017 14:26:21 -0800
Subject: [PATCH v3 0/8] ARM: dts: Switch to new DSA binding
In-Reply-To: <20170117182224.32212-1-f.fainelli@gmail.com>
References: <20170117182224.32212-1-f.fainelli@gmail.com>
Message-ID: <633afd2c-75e4-adeb-f3a0-b59b5f47f1a7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2017 10:22 AM, Florian Fainelli wrote:
> Hi all,
> 
> This patch series converts the in-tree users to utilize the new (relatively)
> DSA binding that was introduced with commit 8c5ad1d6179d ("net: dsa: Document
> new binding"). The legacy binding node is kept included, but is marked
> disabled.
> 
> Changes in v3:
> 
> - collected tags from Andrew and Russell
> - added missing change to arch/arm/boot/dts/kirkwood-rd88f6281-a.dts
> 
> Changes in v2:
> 
> - patch 1: Use an hexadecimal reg property
> - patch 2: fixed the subject
> - patch 3: s/okay/disabled/ for the legacy DSA node
> - patches 7/8: fixed a stray whitespace
> 
> In about 2-3 releases we may consider removing the old DSA binding entirely
> from the kernel.

Gregory, all patches have been reviewed/tested now, can you take this
for an upcoming 4.11 pull request? Thanks!
-- 
Florian
