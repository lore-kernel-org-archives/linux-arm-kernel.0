From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 11 Feb 2016 19:46:42 -0800
Subject: [GIT PULL] bcm2835 DT changes for 4.6
In-Reply-To: <87d1s42yb8.fsf@eliezer.anholt.net>
References: <1454977978-17491-1-git-send-email-eric@anholt.net>
 <DDFB1D8B-805B-488F-9582-796EBCEF287B@sperl.org>
 <87d1s42yb8.fsf@eliezer.anholt.net>
Message-ID: <56BD55A2.20104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2016 10:51, Eric Anholt wrote:
> Martin Sperl <martin@sperl.org> writes:
> 
>>> On 09.02.2016, at 01:32, Eric Anholt <eric@anholt.net> wrote:
>>>
>>> Hi Florian.  Here's the first set of patches for bcm2835 for 4.6.
>>> We've got more DT patches that are going to happen for new boards,
>>> too, but they're still getting polished.
>>>
>>> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
>>>
>>>  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
>>>
>>> are available in the git repository at:
>>>
>>>  git at github.com:anholt/linux.git tags/bcm2835-dt-next-2016-02-04
>>>
>>> for you to fetch changes up to 5ec6f2cd8ec4bcd38ba199ea8711a5ec906d85e7:
>>>
>>>  ARM: bcm2835: Add the Raspberry Pi power domain driver to the DT. (2016-02-02 20:02:45 -0800)
>>>
>>> ----------------------------------------------------------------
>>> This pull request covers mostly DT changes that didn't make it into
>>> 4.5 because required header files went through other trees.
>>>
>>> ----------------------------------------------------------------
>>> Alexander Aring (1):
>>>      ARM: bcm2835: Add the Raspberry Pi power domain driver to the DT.
>>>
>>> Lubomir Rintel (1):
>>>      ARM: bcm2835: dt: Add Raspberry Pi Model A
>>>
>>> Martin Sperl (2):
>>>      ARM: bcm2835: add the auxiliary spi1 and spi2 to the device tree
>>>      ARM: bcm2835: follow dt uart node-naming convention
>>
>> Do you want me to resend a rebased version of:
>>      ARM: bcm2835: add bcm2835-aux-uart support to default DT
>>
>> The corresponding driver has been added to tty/tty-next.
> 
> It hadn't landed last time I checked.  A rebased version that you've
> tested would be great!

OK, please submit this in the next week or so at most, so we can get
this pull request merged, thanks!

Eric, do you have other changes outside of Device Tree?
--
Florian
