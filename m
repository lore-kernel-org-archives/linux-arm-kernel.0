From: cyril@ti.com (Cyril Chemparathy)
Date: Tue, 24 Jul 2012 06:46:14 -0400
Subject: [RFC 07/23] ARM: LPAE: use phys_addr_t for membank size
In-Reply-To: <20120724100454.GD16435@mudshark.cambridge.arm.com>
References: <1343092165-9470-1-git-send-email-cyril@ti.com>
 <1343092165-9470-8-git-send-email-cyril@ti.com>
 <20120724100454.GD16435@mudshark.cambridge.arm.com>
Message-ID: <500E7CF6.2060303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/24/2012 6:04 AM, Will Deacon wrote:
> On Tue, Jul 24, 2012 at 02:09:09AM +0100, Cyril Chemparathy wrote:
>> This patch changes the membank structure's size field to phys_addr_t to allow
>> banks larger than 4G.
>
> This has already been fixed:
>
>    http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7465/1

Excellent.  Thanks.

>
> Will
>

-- 
Thanks
- Cyril
