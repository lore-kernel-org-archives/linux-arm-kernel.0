From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 4 Jan 2017 18:42:48 +0100
Subject: [PATCH 3/8] ARM: dts: armada-388-clearfog: Utilize new DSA binding
In-Reply-To: <87fuky7mjt.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
References: <20170102022249.10657-1-f.fainelli@gmail.com>
 <20170102022249.10657-4-f.fainelli@gmail.com>
 <87shoyeo2j.fsf@free-electrons.com>
 <5a40436a-ebad-8a94-c5c5-546ba33ba545@gmail.com>
 <87fuky7mjt.fsf@weeman.i-did-not-set--mail-host-address--so-tickle-me>
Message-ID: <20170104174248.GG5517@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> That makes me think that we should either remove, or use different
> values for the version described in net/dsa/dsa.c:
> 
>     char dsa_driver_version[] = "0.1";
> 
> Today this is absolutely useless and erroneous.

I think it has been useless for over 9 years.

Feel free to remove it.

     Andrew
