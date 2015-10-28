From: nicola@corna.info (Nicola Corna)
Date: Wed, 28 Oct 2015 06:46:28 +0000
Subject: [PATCH v3 4/4] iio: humidity: si7020: added No Hold read mode
In-Reply-To: <20151027233000.GB1572@katana>
References: <20151027233000.GB1572@katana>
 <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1445976718-7449-4-git-send-email-nicola@corna.info>
Message-ID: <f113de76b2369d404909cfc5158feca4@rainloop.corna.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

October 28 2015 12:30 AM, "Wolfram Sang" <wsa@the-dreams.de> wrote:
> Not a complete review, I just stumbled over this one:
> 
>> + if (client->adapter->quirks &&
>> + client->adapter->quirks->flags |
> 
> '|' should be '&', or?
> 
Yes, sorry. I'll update the patch.

Nicola Corna
>> + I2C_AQ_NO_CLK_STRETCH)
>> + return -ENODEV;
