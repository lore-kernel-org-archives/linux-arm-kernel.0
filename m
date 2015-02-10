From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 09 Feb 2015 21:34:00 -0800
Subject: [PATCH v9 3/3] ARM: dts: add I2C device nodes for Broadcom Cygnus
In-Reply-To: <54D99606.9070309@broadcom.com>
References: <rjui@broadcom.com>
 <1423373126-30024-1-git-send-email-rjui@broadcom.com>
 <1423373126-30024-4-git-send-email-rjui@broadcom.com>
 <20150209121103.GC2491@katana> <54D99606.9070309@broadcom.com>
Message-ID: <54D99848.2080205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 09/02/2015 21:24, Ray Jui a ?crit :
> 
> 
> On 2/9/2015 4:11 AM, Wolfram Sang wrote:
>> On Sat, Feb 07, 2015 at 09:25:26PM -0800, Ray Jui wrote:
>>> Add I2C device nodes and its properties in bcm-cygnus.dtsi but keep
>>> them disabled there. Individual I2C devices can be enabled in board
>>> specific dts file when I2C slave devices are enabled in the future
>>>
>>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>>> Reviewed-by: Kevin Cernekee <cernekee@chromium.org>
>>
>> I usually don't take DTS patches. They should go via arm-soc. Please say
>> so if there are reasons I should take them.
>>
> Okay. I'll send this as an individual patch to arm-soc.

Could you put in  in a branch somewhere on github.com?/cygnus-linus.git
so it's easy for me to pull from there?
--
Florian
