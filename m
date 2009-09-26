From: soni.trilok@gmail.com (Trilok Soni)
Date: Sat, 26 Sep 2009 22:51:11 +0530
Subject: [PATCH 1/4] [INPUT][KEYBOARD] Samsung keypad driver support
In-Reply-To: <20090926095447.GC1331@ucw.cz>
References: <1252494663-17624-1-git-send-email-jsgood.yang@samsung.com>
	<20090926095447.GC1331@ucw.cz>
Message-ID: <5d5443650909261021v298d925cn1d4c08c9ef81517f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On Sat, Sep 26, 2009 at 3:24 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Wed 2009-09-09 20:11:03, jsgood.yang at samsung.com wrote:
>> From: Jinsung Yang <jsgood.yang@samsung.com>
>>
>> Add support for Samsung matrix keypad driver
>
> Could generic matrix keyboard driver be used instead?
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?Pavel

Just looking at initial lines of code of this driver, matrix gpio
keypad driver doesn't fit the need, because this driver is based on
keypad controller on SoC and not through gpios.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
