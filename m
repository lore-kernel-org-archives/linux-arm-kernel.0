From: stefan@datenfreihafen.org (Stefan Schmidt)
Date: Wed, 4 Jul 2018 20:26:13 +0200
Subject: [RFC net-next 00/15] net: A socket API for LoRa
In-Reply-To: <20180701110804.32415-1-afaerber@suse.de>
References: <20180701110804.32415-1-afaerber@suse.de>
Message-ID: <487df785-ddf5-ed81-a253-6afb7f2de811@datenfreihafen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01.07.2018 13:07, Andreas F?rber wrote:
> 
> This patchset, updated from 2017 and extended, is implementing kernel drivers
> for various LoRa chipsets and modules.

I am very happy to see that we now have three people (you, Jian-Hong and
Ben) working towards a lora subsystem for protocol stack and drivers.

Will allocate some time to look over this and provide some review and
feedback how we handled things in the ieee802154 and 6lowpan subsystems.

We are also having a IoT protocols workshop during NetDev Conf next week
in Montreal (short notice if you are not already planning to attend). If
you (or Ben) has soem topics wanted to bring up their please let me know
by pm. Jian-Hong will be there presenting on his lora work and I would
love to get more input from you and Ben on your views on this.

https://netdevconf.org/0x12/session.html?workshop-on-iot-related-mac-layers-header-compression-and-routing-protocols

regards
Stefan Schmidt
