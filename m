From: brian.austin@cirrus.com (Brian Austin)
Date: Wed, 12 Nov 2014 09:17:44 -0600
Subject: [PATCHv2] ASoC: cs42l51: re-hook of_match_table pointer
In-Reply-To: <1415803244-7010-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1415803244-7010-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <alpine.DEB.2.10.1411120916550.23029@heelrod>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This commit exports the of_device_id array in cs42l51, and uses it as
> .of_match_able in cs42l51-i2c.c. This solution was suggested by Brian
> Austin.
> 
> Fixes: a1253ef6d3fa ("ASoC: cs42l51: split i2c from codec driver")
Acked-by: Brian Austin <brian.austin@cirrus.com>

Thanks
