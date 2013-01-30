From: kyungsik.lee@lge.com (=?utf-8?B?7J206rK97Iud?=)
Date: Wed, 30 Jan 2013 13:27:07 +0900
Subject: [RFC PATCH 0/4] Add support for LZ4-compressed kernels
In-Reply-To: <20130129225508.GC30535@twin.jikos.cz>
References: <1359179447-31118-1-git-send-email-kyungsik.lee@lge.com>
 <20130129225508.GC30535@twin.jikos.cz>
Message-ID: <006201cdfea2$116dfbb0$3449f310$@lee@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > It seems that it?s worth trying LZ4 compressed kernel image or ramdisk
> > for making the kernel boot more faster.
> 
> There's another potential user of lz4: btrfs. I've submitted a feature
> preview integrating lz4 compression
> http://thread.gmane.org/gmane.comp.file-systems.btrfs/15744
> and we have tried to integrate the HC mode as well
> http://thread.gmane.org/gmane.comp.file-systems.btrfs/18165
> .
> So far it's on a slow track, conceptually it works, but I the code needs
> some work so it could live under lib/* (we've used the svn sources with
> minor changes, no kernel coding style). It would be easier for me to
> enhance the existing lib/lz4/* codebase.
> 
I don't know much about btrfs. But I guess the lz4 related APIs should
be migrated and integrated under lib/lz4/* like the way lzo implemented.

> Also zram could consider lz4, I'm not sure if there are other potential
> users.
> 
> 
> david

Thanks,
Kyungsik
