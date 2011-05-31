From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 31 May 2011 10:11:27 +0200
Subject: is there the sample for how to use the tcm on userspace ?
In-Reply-To: <BANLkTi=_1cXiQ6A6fCmfywyHHAOvB3DQpA@mail.gmail.com>
References: <BANLkTi=_1cXiQ6A6fCmfywyHHAOvB3DQpA@mail.gmail.com>
Message-ID: <4DE4A2AF.2040708@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/31/2011 04:18 AM, Jello huang wrote:
>   I have readed the tcm.txt but do not get the point. So do i need to
> write char device for the dtcm  or itcm ,then mmap to userspace
> through the char device .
>    

The interface is not designed to be used from userspace,
explain your usecase so I have a chance to understand why
you want to do such a thing.

Yours,
Linus Walleij
