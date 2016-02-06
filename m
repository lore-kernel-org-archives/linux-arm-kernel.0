From: thomas@schloeter.net (=?utf-8?Q?Thomas_Schl=C3=B6ter?=)
Date: Sat, 6 Feb 2016 19:24:50 +0100
Subject: net: mv643xx: interface does not transmit after some time
Message-ID: <E4F9E0D0-9DA8-4E33-9F89-B49E47F11CE0@schloeter.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I am using mainline kernel 4.4 on a QNAP TS-412 (Marvell Kirkwood Feroceon 6281). The network interface mv643xx loses connection after a few minutes to some hours. Only bringing the interface down and up again helps.

Now I have a serial console for debugging. When I ping the dead interface and run ?watch ifconfig eth0? on the serial console, I can see the RX packets counting up while TX packets stays unchanged. Log files only show a message of some services showing a timeout or ?if_sendrawpacket: No buffer space available?.

How can I figure out what is wrong?

Regards,
Thomas
