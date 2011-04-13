From: bengardiner@nanometrics.ca (Ben Gardiner)
Date: Wed, 13 Apr 2011 12:03:39 -0400
Subject: [PATCH 6/6] da8xx: enable the use of the ICPFUNC in i2c-davinci
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C8B3CBD@dbde02.ent.ti.com>
References: <cover.1302031487.git.bengardiner@nanometrics.ca>
	<f1ff3f2888725a1e03541e0be5c0880f0591aea2.1302031487.git.bengardiner@nanometrics.ca>
	<B85A65D85D7EB246BE421B3FB0FBB593024C8B3C9F@dbde02.ent.ti.com>
	<BANLkTi=j=Dp015ZsU44DH3p1s_XdxvAX8Q@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024C8B3CBD@dbde02.ent.ti.com>
Message-ID: <BANLkTi=OCqFTFMyfA3iF_yqQi2Pmxm5V+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2011 at 11:42 AM, Nori, Sekhar <nsekhar@ti.com> wrote:
> On Wed, Apr 13, 2011 at 20:52:05, Ben Gardiner wrote:
>> I understand "check for pdata to be NULL." ?If you think it is the
>> better option I'd be happy to implement it but I don't understand how
>> to implement "let each board choose whether it needs recovery."
>
> This is done by just setting has_pfunc = 1 in the
> davinci_i2c_platform_data defined in the board file.

Ok -- now I get it, thanks. I spin a V2 shortly.

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
