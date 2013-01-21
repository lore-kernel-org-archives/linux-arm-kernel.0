From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Jan 2013 22:30:07 +0000
Subject: One of these things (CONFIG_HZ) is not like the others..
In-Reply-To: <CAKGA1bn0-83d+BFRMGZDZ9MZ2nnx8e8wh-VS3XoG5UQJDC0npg@mail.gmail.com>
References: <CAKGA1bkiowcO7OPSfPmaB6eRj_3FNr+4ONnaQHEZkpxB2XfduQ@mail.gmail.com>
 <201301212041.17951.arnd@arndb.de>
 <CAKGA1bn0-83d+BFRMGZDZ9MZ2nnx8e8wh-VS3XoG5UQJDC0npg@mail.gmail.com>
Message-ID: <201301212230.07393.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 January 2013, Matt Sealey wrote:
> So is that a bug in that it is not available to ARM right now, a bug
> in that it would be impossible for anyone on ARM to have ever tested
> this code, or a bug in that it should NEVER be enabled for ARM for
> some reason? John? Ingo? :)
> 

I think it's a bug that it's not available. That does not look intentional.

	Arnd
