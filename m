From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 1 Sep 2013 13:23:48 +0200
Subject: [PATCH 2/2] ARM: Dove: Add the audio device to the Cubox DT
In-Reply-To: <140d8d8a23f.2784.107cef0f820c2f5d7b7f41463071c310@gmail.com>
References: <20130828113521.35c53365@armhf> <521DCD80.9010105@gmail.com>
 <20130831125128.0e3a23c7@armhf>
 <140d8d8a23f.2784.107cef0f820c2f5d7b7f41463071c310@gmail.com>
Message-ID: <20130901132348.63e98d35@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 01 Sep 2013 11:26:54 +0200
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> Can you please try <&si5351 1>, iirc audio ist connected to it. I will also 
> look it up later.

I applied Russell's patch to always use an external clock, and none
(<&si5351 1> or <&si5351 2>) work! (si5351 from kernel 3.11.0-rc5)

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
