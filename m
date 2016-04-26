From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 26 Apr 2016 12:12:46 +0200
Subject: [PATCH 4/4] ARM: remove duplicate const qualifier
In-Reply-To: <20160425143731.GR32731@imgtec.com> (Eric Engestrom's message of
 "Mon, 25 Apr 2016 15:37:31 +0100")
References: <1461577678-29517-1-git-send-email-eric.engestrom@imgtec.com>
 <20160425095715.GA2366@piout.net> <20160425103911.GO32731@imgtec.com>
 <4641918.pNBP5iAK01@wuerfel> <20160425125809.GP32731@imgtec.com>
 <alpine.LFD.2.20.1604250953200.5091@knanqh.ubzr>
 <20160425143731.GR32731@imgtec.com>
Message-ID: <m337q8fzkx.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Engestrom <eric.engestrom@imgtec.com> writes:

> I can't confirm it (haven't tried), and don't care enough to do it :]
> I guess I'm just dropping the patch then. Like I said, it can't hurt to
> leave them in.

Actually it may hurt (a little bit) - it makes the code less readable.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
