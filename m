From: zonque@gmail.com (Daniel Mack)
Date: Fri, 02 Aug 2013 19:53:24 +0200
Subject: [RFC PATCH V2 0/9] impedance-matcher generic improvements
In-Reply-To: <cover.1375457714.git.jason@lakedaemon.net>
References: <51F2A014.7000209@gmail.com>
 <cover.1375457714.git.jason@lakedaemon.net>
Message-ID: <51FBF214.8070304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On 02.08.2013 17:51, Jason Cooper wrote:
> Here's a new version of my attempt to make this code generically useful.  I've
> tested this on my dreamplug both using the commandline
> 'loadaddrs=appended,0x0700000' and appending all kirkwood*.dtb's.
> 
> It's still hacky and can't update the dtb yet.  But it definitely works.

Merged and pushed, thanks :)

Note the changes on top of yours though. it took me a while to figure
out that my boards won't boots images that are concatinated to the
finale image. I changed that back so that things are treated by objcopy,
and now everything's fine.



Best regards,
Daniel
