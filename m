From: matthieu.castet@parrot.com (Matthieu CASTET)
Date: Fri, 31 Aug 2012 12:29:04 +0200
Subject: [PATCH] hvc_dcc : add support to armv4 and armv5 core
In-Reply-To: <20120831110444.25d9b9fe@pyramind.ukuu.org.uk>
References: <1346404916-27616-1-git-send-email-castet.matthieu@free.fr>
 <20120831110444.25d9b9fe@pyramind.ukuu.org.uk>
Message-ID: <504091F0.1090703@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alan Cox a ?crit :
> On Fri, 31 Aug 2012 11:21:56 +0200
> Matthieu CASTET <castet.matthieu@free.fr> wrote:
> 
>> Signed-off-by: Matthieu Castet <matthieu.castet@parrot.com>
>> ---
>>  drivers/tty/hvc/hvc_dcc.c |   34 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
> 
> This is a step in the wrong direction. This should all be runtime handled
> 
> NAK.
> 

AFAIK you can't build a arm kernel that support arm6/armv7 and armv5.
And I am not sure it will be possible one day.
