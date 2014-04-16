From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Wed, 16 Apr 2014 19:39:49 +0100
Subject: [PATCH v4 21/21] misc: support for I-8024 in LP-8x4x
In-Reply-To: <1397668667-27328-15-git-send-email-ynvich@gmail.com>
References: <1397668411-27162-7-git-send-email-ynvich@gmail.com>
 <1397668667-27328-1-git-send-email-ynvich@gmail.com>
 <1397668667-27328-15-git-send-email-ynvich@gmail.com>
Message-ID: <20140416193949.47f4ea68@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Apr 2014 21:17:26 +0400
Sergei Ianovich <ynvich@gmail.com> wrote:

> Status of I-8042 4 analog output channels can be managed via
> sysfs.

Surely this is an iio interface and should follow the same API as
everyone else ?

Alan
