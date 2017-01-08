From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Sun, 8 Jan 2017 11:41:58 +0100
Subject: [PATCH 08/22] power: supply: add AC power supply driver for
 AXP20X and AXP22X PMICs
In-Reply-To: <d6661ff6-442c-5535-aec2-35066577f119@kernel.org>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-9-quentin.schulz@free-electrons.com>
 <d6661ff6-442c-5535-aec2-35066577f119@kernel.org>
Message-ID: <4b893807-99c2-f0ba-9eec-d93c52c2f151@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

On 07/01/2017 20:31, Jonathan Cameron wrote:
> On 02/01/17 11:37, Quentin Schulz wrote:
[...]
>> +		/*
>> +		 * IIO framework gives mV but Power Supply framework gives ?V.
>> +		 */
> single line comment syntax throughout or we'll have to face a patch 'fixing' it.

I actually had to make it a multiple lines comment to make checkpatch
happy. Maybe there is something with the encoding of the ? symbol? I'll
retry with a u instead and let you know.

[...]

Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
