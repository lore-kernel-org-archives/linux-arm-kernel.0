From: vivien.didelot@savoirfairelinux.com (Vivien Didelot)
Date: Fri, 23 Aug 2013 16:45:33 -0400 (EDT)
Subject: [PATCH] misc: (at24) move header to linux/platform_data/
In-Reply-To: <20130823201149.GA5640@katana>
Message-ID: <169123028.921974.1377290733515.JavaMail.root@mail>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram wrote:

> > IMHO it makes sense. Why wouldn't we want all platform_data in
> > include/linux/platform_data/?
> 
> For the same reason we don't want all driver source files in one
> directory? It's a mess.

Well, that's different. Not all drivers expose platform data, but many
subsystems have drivers with platform data. A common include directory
for the *_platform_data structure definitions makes sense.

Regards,
Vivien
