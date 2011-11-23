From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 23 Nov 2011 12:27:31 +0200
Subject: [PATCH 0/7] Introducing a generic AMP framework
In-Reply-To: <4ECC67B9.4050306@codeaurora.org>
References: <1319536106-25802-1-git-send-email-ohad@wizery.com>
 <4ECC67B9.4050306@codeaurora.org>
Message-ID: <CAK=WgbYyrbZLmDOx8yKWwjhn2MYN8669FDRvsYZSyLj1equcTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 5:25 AM, Saravana Kannan <skannan@codeaurora.org> wrote:
> Sorry for the rant, this naming just rubs me the wrong way. I definitely
> appreciate the idea behind these patches.

I don't share the same naming concerns you have (if any, then
confusion with the bluetooth AMP patches and prefixes is more of a
concern to me), but I don't care deeply about names.

Feel free to offer a different name, though really 'amp' here only
describes the general model and motivation and is rarely used
throughout the code; we mostly either use 'remoteproc' or 'rpmsg',
which respectively refer to the two frameworks that are being added
(the former responsible for controlling the state of the remote
processors, and the latter for communicating with them).

Thanks,
Ohad.
