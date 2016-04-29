From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 29 Apr 2016 09:41:18 -0700
Subject: [PATCH v2 0/5] Add SATA3 support for Broadcom NS2 SVK
In-Reply-To: <57231D12.9080605@ti.com>
References: <1459140510-5317-1-git-send-email-anup.patel@broadcom.com>
 <57231D12.9080605@ti.com>
Message-ID: <57238EAE.80403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/04/16 01:36, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Monday 28 March 2016 10:18 AM, Anup Patel wrote:
>> The Broadcom NS2 SoC has a AHCI compliant SATA3 controller with
>> two ports.
>>
>> This patchset adds common Broadcom SATA3 PHY driver and related
>> DT bindings document. It also adds appropriate DT nodes in NS2 DT.
>>
>> The patchset is based on v4.6-rc1 tag and is available in branch
>> ns2_sata3_v2 of https://github.com/Broadcom/arm64-linux.git
>>
>> All patches have been tested on Broadcom NS2 SVK.
> 
> merged the first 3 patches to linux-phy tree.

And applied patches 4-5 to devicetree-arm64/next, thanks!
-- 
Florian
