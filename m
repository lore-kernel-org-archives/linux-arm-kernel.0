From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Tue, 8 Apr 2014 17:19:29 +0100
Subject: [PATCH v6 2/5] ARM: Add Krait L2 register accessor functions
In-Reply-To: <20140408151056.GH30077@pd.tnic>
References: <1396641450-12854-1-git-send-email-sboyd@codeaurora.org>
 <1396641450-12854-3-git-send-email-sboyd@codeaurora.org>
 <20140407201838.GC20822@pd.tnic>
 <20140407215649.GH9985@codeaurora.org>
 <20140408064328.GB30077@pd.tnic> <534406BD.8000702@codeaurora.org>
 <20140408151056.GH30077@pd.tnic>
Message-ID: <20140408171929.68f328a9@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Apr 2014 17:10:56 +0200
Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Apr 08, 2014 at 10:25:01AM -0400, Christopher Covington wrote:
> > As I understand it, the license authors. They find it important to maintain
> > clarity even when files get copied into other projects.
> > 
> > http://www.gnu.org/licenses/gpl-howto.html
> > 
> > http://www.gnu.org/licenses/gpl-faq.html#NoticeInSourceFile
> 
> Right, so what is wrong with stating the same thing in two lines:
> 
> "Copyright (c) 2011-2013, The Linux Foundation. All rights reserved.
> 
> This file is licensed under GNU GPLv2. See COPYING for full license text.

The COPYING file may not be present. There may be cases where the absence
of the warranty statement in the header is problematic etc etc.

Corporate legals have their own policies on this and there is no point
fighting them because

- they are the ones qualified to make the decision

- the corporate legal angle is often "do this or don't release it"

- we have huge numbers of files using that same no warranty in every
  file, and major companies who specify it must be present in their code
  releases


Including the without warranty is standard practice at a lot of
companies. It's not even wasting space - it'll compress beautifully as
there are already lots of similar headers all over the tree.

Alan
