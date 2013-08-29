From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 29 Aug 2013 11:46:36 +0200
Subject: [PATCH 1/2] ARM: Dove: Add the audio devices in DT
In-Reply-To: <20130828131548.0009d613@skate>
References: <20130828113459.48ecbb34@armhf> <521DCD33.2070008@gmail.com>
 <20130828121943.1c8327ca@skate> <521DD057.4040208@gmail.com>
 <20130828131548.0009d613@skate>
Message-ID: <20130829114636.18a09c72@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Aug 2013 13:15:48 +0200
Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> For what reason does the driver needs to know whether it's the instance
> 0 or instance 1 ? If it's needed for some specific reason, then there
> should probably be something like marvell,i2s-channel-id = <0> and
> marvell,i2s-channel-id = <1>.

It seems simpler to use aliases.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
