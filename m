From: rodrigo@tjader.xyz (=?UTF-8?Q?Rodrigo_Exterck=C3=B6tter_Tj=C3=A4der?=)
Date: Thu, 15 Nov 2018 12:46:06 -0200
Subject: [PATCH 1/2] arm64: dts: allwinner: Olimex A64-OLinuXino: enable
 eMMC.
In-Reply-To: <20181005154844.234g5k3fw5txqxsl@flea>
References: <20180921142811.h5jraemk565alh3i@flea>
 <CAG7TQgE_KU_cK_4E+NG8Qcw-QB2=C6YoqBYR2svmWxywFyySCw@mail.gmail.com>
 <20180925090139.qbu6tqav5oth7zkw@flea>
 <CAG7TQgFTsR4pf4jAcWMFoOmiP7AXYqjts60RP2kuJGU44AcQJQ@mail.gmail.com>
 <20180927081711.llmwnvpu73loe5iv@flea>
 <CAG7TQgGMkvBnNE_WEth8gscKxN3qN8a44mNMWz3QP-2+JKfOzg@mail.gmail.com>
 <20180929154754.abz3byvrufvnf4dq@flea>
 <CAG7TQgGS7DkLpNVYqfCD-9vMZkeY6r+L-5oXKWef3x-OVbqjtw@mail.gmail.com>
 <20181002131312.soqwybsohdifvso3@flea>
 <CAG7TQgHWCJTaM+pFYFq0_8nWg7sA+d0huqu96sjhqZfeHwqbGQ@mail.gmail.com>
 <20181005154844.234g5k3fw5txqxsl@flea>
Message-ID: <CAG7TQgGO-CjPE6SAUa53GYhMr5-yVe0YaAL3UV15E+f9kKZVwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 5, 2018 at 12:48 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > What about the idea of keeping the current dt for the most featureful
> > variant and creating new dts for the other two?
> >
> > That would make it so that no one's device stops working and would
> > have mailine support for all three devices.
>
> IIRC that has been the first introduced version, so that would make
> sense. Chen-Yu, any opinion?
>
> > Also, the current device tree doesn't represent any existing device:
> > it has wifi on but no emmc. That variation does not exist.
>
> Most of our device tree are far from complete, so you shouldn't treat
> them as such.

So, any agreement on what is to be done about the devices tree for the
A64-OLinuXino devices?

In my opinion the best path would be keeping the current dt for the
most featureful variant and creating new dts for the other two.
