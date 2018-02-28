From: tharvey@gateworks.com (Tim Harvey)
Date: Wed, 28 Feb 2018 13:16:02 -0800
Subject: [RFC 2/4] mfd: add Gateworks System Controller core driver
In-Reply-To: <20180228185302.GD1203@lunn.ch>
References: <1519780874-8558-1-git-send-email-tharvey@gateworks.com>
 <1519780874-8558-3-git-send-email-tharvey@gateworks.com>
 <20180228185302.GD1203@lunn.ch>
Message-ID: <CAJ+vNU2aeFAKf6e7RashG50Gu5qb3mqGvJUEPprh4AjFGs+MLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 10:53 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>> +             dev_err(&client->dev, ">> 0x%02x %d\n", reg, ret);
>> +             return ret;
>> +     }
>> +     dev_dbg(&client->dev, ">> 0x%02x=0x%02x (%d)\n", reg, val, retry);
>> +
>> +        return 0;
>
> Hi Tim
>
> There appears to be a few spaces vs tabs issues in this file.
>
>       Andrew
>

Thanks. I'll run through checkpatch prior to v2.

Tim
