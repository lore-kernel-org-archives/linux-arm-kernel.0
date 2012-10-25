From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Oct 2012 15:13:43 +0000
Subject: [GIT PULL] first set of ux500 for ARM SoC for v3.8
In-Reply-To: <CACRpkdZ9fUUugHAPGw8kEZDFnDWyyZ-b2iUdfCu2Hhhg4swaPQ@mail.gmail.com>
References: <CACRpkdasaP_xVfQtzq29UNJBXetrUUzqpn90T6_Gr0kOsV8GeQ@mail.gmail.com>
 <201210251344.44546.arnd@arndb.de>
 <CACRpkdZ9fUUugHAPGw8kEZDFnDWyyZ-b2iUdfCu2Hhhg4swaPQ@mail.gmail.com>
Message-ID: <201210251513.43931.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 October 2012, Linus Walleij wrote:
> On Thu, Oct 25, 2012 at 3:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > Please remember to write the pull request in a way that lets us reuse some
> > of the text for the merge changeset comment. Ideally in a signed tag
> > so git puts it in there automatically.
> 
> So what was wrong with this signed tag, looking like that?
> 
> ----------------------------------------------------------------
> A first set of Ux500 core patches for v3.8:
> - Support the HREF520 board
> - Add the device serial number to the entropy pool
> 
> ----------------------------------------------------------------
> 
> I guess what I'm after is what makes it reusable if this one
> isn't.

The tag looks great, but you were sending the pull request for
the branch "ux500-core", not for the tag "ux500-core-for-arm-soc".

This has happened to me a few times before, especially when pushing
the tag just before sending the pull request. In that case,
git-request-pull cannot find the tag on the server because it has
not been mirrored back from the git+ssh server to the publically
accessible one that it reads the tags from.

	Arnd
