From: const@makelinux.com (Constantine Shulyupin)
Date: Thu, 18 Oct 2012 00:29:43 +0200
Subject: [Celinux-dev] PDF documentation
In-Reply-To: <507F2B6D.9070607@am.sony.com>
References: <CAE7jHC83biZy7TNYSr+-X85tpenqtAHuwSO47Q-6+XRF0fUxLA@mail.gmail.com>
 <20121016140555.12139.qmail@stuge.se>
 <CAE7jHC8ru3TVaRXWvn5p6795LTk-WkVZZRJxB1-vJag+=H62jw@mail.gmail.com>
 <20121017165125.12301.qmail@stuge.se>
 <CAE7jHC_PL_C-4eY6LaKsfqdYhT2AR-djo3Swn6dmYZYPKJOX3w@mail.gmail.com>
 <507F2B6D.9070607@am.sony.com>
Message-ID: <CAE7jHC9zajtGbXk6Rz3W7WEyDREJ37UfKRX2U73H3oQ6HoBqcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2012 at 12:04 AM, Tim Bird <tim.bird@am.sony.com> wrote:
> Being able to identify a page of an existing online PDF is already
> possible with URLs.  See
> http://stackoverflow.com/questions/125632/is-it-possible-to-link-to-a-bookmark-within-a-pdf-using-url-parameters
Yes, I know. I already wrote about it the fist e-mail. It is not
applicable in all cases.

> So, the following would get you to page 34, in the original PDF:
> http://www.macronix.com/QuickPlace/hq/PageLibrary4825740B00298A3B.nsf/h_Index/DBACA1C90564EBB248257639003A563A/$File/MX29GL128E,%203V%20(VI-O),%20128Mb,%20v1.5.pdf#page=34

Yes, it works when pdf is hosted properly (not forced for download),
not archived and relatively small.
This method will not work with
http://focus.ti.com/pdfs/wtbu/OMAP4460_ES1.x_PUBLIC_TRM_vI.zip

Even unzipped pdf is 23 MB - too heavy for online browning.

> Careful there.  These documents are copyright.  Even though the OMAP4460 document
> says it is "public", I'm not sure it's legal to post verbatim contents to a web site.
>
> So - useful or not, I'm worried it's not legal.
>  -- Tim

Quote:

Reproduction of significant portions of TI information in TI data
books or data sheets is permissible only if reproduction is without
alteration and is accompanied by all associated warranties,
conditions, limitations, and notices.

from http://makelinux.net/lib/ti/OMAP4460/doc-5864

Thank you, Tim.

>
> =============================
> Tim Bird
> Architecture Group Chair, CE Workgroup of the Linux Foundation
> Senior Staff Engineer, Sony Network Entertainment
> =============================
>



-- 
Constantine Shulyupin
http://www.MakeLinux.com/
Embedded Linux Systems,
Device Drivers, TI DaVinci
