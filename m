From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 8 Jan 2013 20:51:08 +0530
Subject: [RFC v2 14/18] ARM: OMAP2+: AM33XX: control: Add some control
 module registers and APIs
In-Reply-To: <1356959231-17335-15-git-send-email-vaibhav.bedia@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-15-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <50EC3964.3060708@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 31 December 2012 06:37 PM, Vaibhav Bedia wrote:
> Add minimal APIs for writing to the IPC and the M3_TXEV registers
> in the Control module. These will be used in a subsequent patch which
> adds suspend-resume support for AM33XX.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Cc: Tony Lingren <tony@atomide.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
On Control module, we are trying to move driver/module
specific code to respective drivers. Can you not
add below code to ipc related driver component.

If not, then patch as such is fine with me.

Regards
Santosh
