From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 28 Feb 2018 19:53:02 +0100
Subject: [RFC 2/4] mfd: add Gateworks System Controller core driver
In-Reply-To: <1519780874-8558-3-git-send-email-tharvey@gateworks.com>
References: <1519780874-8558-1-git-send-email-tharvey@gateworks.com>
 <1519780874-8558-3-git-send-email-tharvey@gateworks.com>
Message-ID: <20180228185302.GD1203@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +		dev_err(&client->dev, ">> 0x%02x %d\n", reg, ret);
> +		return ret;
> +	}
> +	dev_dbg(&client->dev, ">> 0x%02x=0x%02x (%d)\n", reg, val, retry);
> +
> +        return 0;

Hi Tim

There appears to be a few spaces vs tabs issues in this file.

      Andrew
 
