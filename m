From: danindrey@mail.ru (Andrey Danin)
Date: Tue, 21 Jul 2015 11:51:15 +0300
Subject: [PATCH v3 4/4] dt: paz00: define nvec as child of i2c bus
In-Reply-To: <4778199.vGjAP5lpOS@fb07-iapwap2>
References: <1437424546-30405-1-git-send-email-danindrey@mail.ru>
 <55AD73F4.2050502@wwwdotorg.org> <55ADE829.4030108@mail.ru>
 <4778199.vGjAP5lpOS@fb07-iapwap2>
Message-ID: <55AE0803.10603@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.07.2015 11:25, Marc Dietrich wrote:
> I think in this case it would be better to leave nvec and dt as it is for now,
> and just add the slave function to tegra-i2c. Otherwise we will again have two
> different "nvidia,nvec-slave" bindings (one for the intermediate hack and one
> for the final representation). As an alternative, you could also add slave
> function and port nvec in the same series.
>
First patch only adds slave functionality to tegra-i2c driver. I sent v3 
to fix only tegra-i2c as Wolfram suggested.

Unfortunately I haven't fixed all defects and I will resend patch(es).
I can resend only first patch (for tegra-i2c) if it is more obvious for 
everyone.
