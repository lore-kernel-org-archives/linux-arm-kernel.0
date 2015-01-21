From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Wed, 21 Jan 2015 12:46:27 +0100
Subject: [PATCH] bluetooth: Add hci_h4p driver
In-Reply-To: <20150121110131.GA19792@amd>
References: <20141223130219.GA5731@amd>
 <7522CAC7-AFD9-470F-B4F8-3C39942DBC04@holtmann.org>
 <20150121110131.GA19792@amd>
Message-ID: <201501211246.27449@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 January 2015 12:01:31 Pavel Machek wrote:
> > > Strange, where do you see DOS style line breaks?
> > > Checkpatch here does not warn about that, and they really
> > > should not be there.
> > 
> > If that would be the only pieces, then I would have fixed it
> > already. That is not the big deal. The rest of checkpatch
> > is what I am not going to fix for you.
> 
> I can fix the checkpatch, but I'd like to understand how ^Ms
> got there, because otherwise it will happen again.
> 

IIRC lines in email according to RFC2822 specification must be 
delimited by CRLF. Maybe this is reason?

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150121/d67fb4f3/attachment-0001.sig>
