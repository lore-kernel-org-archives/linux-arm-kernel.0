From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 28 Jul 2017 16:59:52 -0700
Subject: [PATCH v3 0/4] Broadcom STB S2/S3/S5 support for ARM and MIPS
In-Reply-To: <72d54e9c-6a50-2eac-52db-b1e8c234c552@broadcom.com>
References: <20170706222225.9758-1-f.fainelli@gmail.com>
 <72d54e9c-6a50-2eac-52db-b1e8c234c552@broadcom.com>
Message-ID: <4bebae92-5ae3-8b89-a85a-c06f9d70d658@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/2017 12:52 PM, Florian Fainelli wrote:
> On 07/06/2017 03:22 PM, Florian Fainelli wrote:
>> Hi,
>>
>> This patch series adds support for S2/S3/S5 suspend/resume states on
>> ARM and MIPS based Broadcom STB SoCs.
>>
>> This was submitted a long time ago by Brian, and I am now picking this
>> up and trying to get this included with support for our latest chips.
>>
>> Provided that I can collect the necessary Acks from Rob (DT) and other
>> people (Rafael?) I would probably take this via the Broadcom ARM SoC
>> pull requests.
> 
> Rafael, any feedback on this?

Applied these 4 patches to drivers/next now.
-- 
Florian
