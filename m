From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 22 Nov 2013 14:06:49 -0200
Subject: [PATCH] backlight: pwm_bl: Do not make the regulator mandatory
In-Reply-To: <20131122145224.GO14725@sirena.org.uk>
References: <20131122142231.GA1741@ulmo.nvidia.com>
 <20131122145224.GO14725@sirena.org.uk>
Message-ID: <CAOMZO5Bxp5pWxS35N2hGZcpRvM8WueLz3_dNL=EpJQLro4sKVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 12:52 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Nov 22, 2013 at 03:22:32PM +0100, Thierry Reding wrote:
>
>> Cc'ing Mark Brown, perhaps he can help figure out what's causing this.
>
> The obvious question is what kernel this is being tested on...

Tested linux-next 20131120 originally and display was blank.

Now on 20131122 the display works fine.

Regards,

Fabio Estevam
