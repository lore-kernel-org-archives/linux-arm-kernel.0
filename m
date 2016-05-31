From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 31 May 2016 10:09:39 -0700
Subject: [PATCH v2 0/4] hw rng support for NSP SoC
In-Reply-To: <20160531101934.GM15376@gondor.apana.org.au>
References: <1464343841-29504-1-git-send-email-yendapally.reddy@broadcom.com>
 <20160531101934.GM15376@gondor.apana.org.au>
Message-ID: <574DC553.4030009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/31/2016 03:19 AM, Herbert Xu wrote:
> On Fri, May 27, 2016 at 06:10:37AM -0400, Yendapally Reddy Dhananjaya Reddy wrote:
>> This patchset contains the hw random number generator support for the
>> Broadcom's NSP SoC. The block is similar to the block available in
>> bcm2835 with different default interrupt mask value. Due to lack of
>> documentation, I cannot confirm the interrupt mask register details
>> in bcm2835. In an effort to not break the existing functionality of
>> bcm2835, I used a different compatible string to mask the interrupt
>> for NSP SoC. Please let me know. Also supported providing requested
>> number of random numbers instead of static size of four bytes.
>>
>> The first patch contains the documentation changes and the second patch
>> contains the support for rng available in NSP SoC. The third patch
>> contains the device tree changes for NSP SoC. The fourth patch contains
>> the support for reading requested number of random numbers.
>>
>> This patch set has been tested on NSP bcm958625HR board.
>> This patch set is based on v4.6.0-rc1 and is available from github
>> repo: https://github.com/Broadcom/cygnus-linux.git
>> branch: nsp-rng-v2
>>
>> Changes since v1
> 
> All applied.

FYI, ARM Device Tree patches usually go via ARM SoC pull requests, so it
is best if this is planned in advance. Can you make sure you document
that there could be a merge conflict in your pull request to Linus?

Thanks
-- 
Florian
