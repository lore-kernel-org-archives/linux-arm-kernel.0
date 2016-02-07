From: thomas@schloeter.net (=?utf-8?Q?Thomas_Schl=C3=B6ter?=)
Date: Sun, 7 Feb 2016 22:11:57 +0100
Subject: net: mv643xx: interface does not transmit after some time
In-Reply-To: <20160206231935.GA30734@jirafa.cyrius.com>
References: <E4F9E0D0-9DA8-4E33-9F89-B49E47F11CE0@schloeter.net>
 <20160206183414.GD17218@lunn.ch> <20160206231935.GA30734@jirafa.cyrius.com>
Message-ID: <E44E7300-840C-4773-8D8B-BADBB9E3929C@schloeter.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 07.02.2016 um 00:19 schrieb Martin Michlmayr <tbm@cyrius.com>:
> 
> * Andrew Lunn <andrew@lunn.ch> [2016-02-06 19:34]:
>> Can you find an easily way to reproduce it? iperf, or scp a big file
>> etc.
> 
> FWIW, we had a similar bug report in Debian recently:
> https://lists.debian.org/debian-arm/2016/01/msg00098.html
> 
> Turning off TCP RX and TX offloading make it go away:
> https://lists.debian.org/debian-arm/2016/01/msg00100.html

Sounds interesting. I will try that.

> Hopefully Thomas can do a bisect.

I have never used that feature before. As far as I understand, I have to mark the last known good revision good and the most recent bad. Then I try every version in between which has changef related code. Right?

Actually I don't have a last good version as I had the original QNAP fw installed before.

4.3, which I installed during my first try was bad and 4.4 did not fix it. What can I do now? Should I provide my complete kernel config file?
At the moment I am trying Ian Campbell's patch as suggested by Andrew.

Thomas

@Martin: Sorry for reposting to your address, I did not manage to send plain text mail from my iPhone.
