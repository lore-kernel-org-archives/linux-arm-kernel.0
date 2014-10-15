From: jbaron@akamai.com (Jason Baron)
Date: Wed, 15 Oct 2014 15:55:51 -0400
Subject: arm: JUMP_LABEL and DEBUG_SET_MODULE_RONX should be mutually
 exclusive?
In-Reply-To: <CAGXu5jLEAjR+X0KnnipGH2gp569_PFp5DYyfgXU=Szxgk5EcpA@mail.gmail.com>
References: <20141015122102.GB4427@stinkpad>
 <CAGXu5jLEAjR+X0KnnipGH2gp569_PFp5DYyfgXU=Szxgk5EcpA@mail.gmail.com>
Message-ID: <543ED147.7090407@akamai.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2014 11:34 AM, Kees Cook wrote:
> On Wed, Oct 15, 2014 at 5:21 AM, Paolo Pisati <p.pisati@gmail.com> wrote:
>> Hi,
>>
>> i keep hitting this with BRIDGE=m, JUMP_LABEL=y and DEBUG_SET_MODULE_RONX=y:
> I think my RO/NX patch series solves this. I sent a pull request, but
> I haven't seen any movement on it. :(
>

Please let me know if this doesn't fix it, I don't want to see JUMP_LABEL
disabled b/c DEBUG_SET_MODULE_RONX is set.

Thanks,

-Jason
