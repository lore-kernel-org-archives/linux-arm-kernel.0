From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 11 Jan 2016 16:16:31 +0000
Subject: [PATCH v2] spi: atmel: improve internal vs gpio chip-select choice
In-Reply-To: <20160111161333.GK6588@sirena.org.uk> (Mark Brown's message of
 "Mon, 11 Jan 2016 16:13:33 +0000")
References: <1452528102-26458-1-git-send-email-mans@mansr.com>
 <20160111161333.GK6588@sirena.org.uk>
Message-ID: <yw1xd1t8w0ps.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@kernel.org> writes:

> On Mon, Jan 11, 2016 at 04:01:42PM +0000, Mans Rullgard wrote:
>> The driver currently chooses between internal chip-select or gpio
>> based on the existence of the cs-gpios DT property which fails on
>> non-DT systems and also enforces the same choice for all devices.
>
> Normally you shouldn't send incremental patches against patches that
> have already been applied.

Should or shouldn't?

> However in this case I'm going to drop your original patch anyway due
> to the issue that was found so it's OK.

Sorry, I hadn't noticed it was already applied.  Too many trees to keep
track of.

-- 
M?ns Rullg?rd
