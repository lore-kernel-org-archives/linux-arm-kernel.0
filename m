From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 2 Aug 2013 14:43:52 -0400
Subject: [RFC PATCH V2 0/9] impedance-matcher generic improvements
In-Reply-To: <51FBF214.8070304@gmail.com>
References: <51F2A014.7000209@gmail.com>
 <cover.1375457714.git.jason@lakedaemon.net>
 <51FBF214.8070304@gmail.com>
Message-ID: <20130802184352.GA5882@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel,

On Fri, Aug 02, 2013 at 07:53:24PM +0200, Daniel Mack wrote:
> Hi Jason,
> 
> On 02.08.2013 17:51, Jason Cooper wrote:
> > Here's a new version of my attempt to make this code generically useful.  I've
> > tested this on my dreamplug both using the commandline
> > 'loadaddrs=appended,0x0700000' and appending all kirkwood*.dtb's.
> > 
> > It's still hacky and can't update the dtb yet.  But it definitely works.
> 
> Merged and pushed, thanks :)
> 
> Note the changes on top of yours though. it took me a while to figure
> out that my boards won't boots images that are concatinated to the
> finale image. I changed that back so that things are treated by objcopy,
> and now everything's fine.

Ok, that's probably cleaner anyway.  I did get to learn more about
linker scripts, so that was fun. :-)

I have one change to catch up to yours (replacing __end_of_image), plus
I added versioning support for when you want to tag a release.  Feel
free to pull from:

  git://git.infradead.org/users/jcooper/impedance-matcher.git dreamplug

thx,

Jason.
