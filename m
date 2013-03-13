From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Mar 2013 14:31:46 -0600
Subject: [PATCH v8 11/12] leds: Kconfig for Palmas LEDs
In-Reply-To: <513A1C25.7050204@slimlogic.co.uk>
References: <1362662276-20792-1-git-send-email-ian@slimlogic.co.uk>
 <1362662276-20792-11-git-send-email-ian@slimlogic.co.uk>
 <A874F61F95741C4A9BA573A70FE3998F82E45A15@DQHE02.ent.ti.com>
 <513A1C25.7050204@slimlogic.co.uk>
Message-ID: <5140E232.2080701@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2013 10:13 AM, Ian Lartey wrote:
> On 08/03/13 01:13, Kim, Milo wrote:
>>> Add the Kconfig and Makefile for the Palmas LED driver.
>>
>> It would be better if the Palmas LED driver files are combined into
>> one patch.
>> [PATCH v8 09/12] leds: Add support for Palmas LEDs
>> [PATCH v8 11/12] leds: Kconfig for Palmas LEDs
> 
> [PATCH v8 11/12] leds: Kconfig for Palmas LEDs
> can often cause a merge conflict if there are already
> additional drivers/files in the leds directory
> 
> [PATCH v8 09/12] leds: Add support for Palmas LEDs
> has more chance of being applied without any issues
> (unless the person taking the patch already has
> their own leds-palmas.c.

A merge conflict isn't really influenced at all by how many other files
are included in the patch that causes it, and both files are going to
end up going through the same tree at the same time. So, there's no
benefit at all that I can see from splitting the C file and Kconfig.
