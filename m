From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Tue, 25 Oct 2016 12:57:37 +0200
Subject: [RFC] shutdown machine when li-ion battery goes below 3V
In-Reply-To: <20161025105604.GA25855@amd>
References: <20161024212250.GA31336@amd>
 <20161024212932.uhjz752z2cy5hohl@atomide.com>
 <20161024214152.GA32310@amd> <201610242348.47484@pali>
 <20161025102435.GA6916@amd> <20161025105320.GK12154@pali>
 <20161025105604.GA25855@amd>
Message-ID: <20161025105737.GL12154@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 October 2016 12:56:04 Pavel Machek wrote:
> Take a look at code. Health is not read from hardware unless battery
> is calibrated.

Then it is bug. EDVF should be accepted also when battery is not
calibrated.

-- 
Pali Roh?r
pali.rohar at gmail.com
